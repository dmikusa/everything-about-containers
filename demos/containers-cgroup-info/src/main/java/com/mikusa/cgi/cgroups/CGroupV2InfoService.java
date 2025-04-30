package com.mikusa.cgi.cgroups;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class CGroupV2InfoService {
    private final String rootPath;

    public static final List<String> CGROUP_CPU_PATHS =
            List.of("cpu.idle", "cpu.max", "cpu.max.burst", "cpu.stat", "cpu.weight");

    public static final List<String> CGROUP_MEMORY_PATHS = List.of(
            "memory.current",
            "memory.high",
            "memory.low",
            "memory.max",
            "memory.min",
            "memory.peak",
            "memory.swap.current",
            "memory.swap.high",
            "memory.swap.max",
            "memory.swap.peak");

    public record CgroupResult(Optional<Long> value, boolean max) {}

    public CGroupV2InfoService(@Value("${cgi.cgroupv2.rootPath}") String rootPath) {
        this.rootPath = rootPath;
    }

    public Map<String, List<CgroupResult>> loadFiles(List<String> paths) {
        if (!Files.exists(Path.of(rootPath))) {
            throw new RuntimeException("root path [%s] does not exist".formatted(rootPath));
        }

        return paths.stream()
                .flatMap(p -> switch (p) {
                    case "cpu.max" -> Stream.of(Map.entry("cpu.max", readXNumbers(Path.of(rootPath, "cpu.max"), 2)));
                    case "cpu.stat" -> readStats().entrySet().stream();
                    default -> Stream.of(Map.entry(p, readXNumbers(Path.of(rootPath, p), 1)));
                })
                .collect(Collectors.toMap(i -> i.getKey(), i -> i.getValue()));
    }

    private Map<String, List<CgroupResult>> readStats() {
        try {
            String data = Files.readString(Path.of(rootPath + "cpu.stat"));
            return Arrays.stream(data.split("\n"))
                    .map(line -> line.trim().split(" "))
                    .filter(splitLine -> splitLine.length == 2)
                    .collect(Collectors.toMap(
                            splitLine -> "cpu.stat.%s".formatted(splitLine[0].trim()),
                            splitLine -> List.of(
                                    new CgroupResult(Optional.of(Long.parseLong(splitLine[1].trim())), false))));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private List<CgroupResult> readXNumbers(Path path, int x) {
        try {
            String data = Files.readString(path).trim();
            return Arrays.stream(data.split(" ", x)).map(this::convertTo).toList();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private CgroupResult convertTo(String value) {
        return switch (value) {
            case null -> null;
            case "max" -> new CgroupResult(Optional.empty(), true);
            default -> new CgroupResult(Optional.of(Long.parseLong(value)), false);
        };
    }
}
