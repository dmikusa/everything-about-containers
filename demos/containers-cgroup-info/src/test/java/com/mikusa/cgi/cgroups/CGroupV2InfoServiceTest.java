package com.mikusa.cgi.cgroups;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.junit.jupiter.api.Test;

class CGroupV2InfoServiceTest {
    @Test
    void shouldLoadCGroupV2Info() {
        CGroupV2InfoService cGroupV2InfoService =
                new CGroupV2InfoService("./src/test/resources/com/mikusa/cgi/cgroups/test-1/");
        Map<String, List<CGroupV2InfoService.CgroupResult>> cpuStats =
                cGroupV2InfoService.loadFiles(CGroupV2InfoService.CGROUP_CPU_PATHS);

        assertThat(cpuStats)
                .containsExactlyInAnyOrderEntriesOf(Map.ofEntries(
                        Map.entry("cpu.idle", List.of(new CGroupV2InfoService.CgroupResult(Optional.of(0L), false))),
                        Map.entry(
                                "cpu.max",
                                List.of(
                                        new CGroupV2InfoService.CgroupResult(Optional.empty(), true),
                                        new CGroupV2InfoService.CgroupResult(Optional.of(100000L), false))),
                        Map.entry(
                                "cpu.max.burst", List.of(new CGroupV2InfoService.CgroupResult(Optional.of(0L), false))),
                        Map.entry(
                                "cpu.weight", List.of(new CGroupV2InfoService.CgroupResult(Optional.of(100L), false))),
                        Map.entry(
                                "cpu.stat.usage_usec",
                                List.of(new CGroupV2InfoService.CgroupResult(Optional.of(315422L), false))),
                        Map.entry(
                                "cpu.stat.user_usec",
                                List.of(new CGroupV2InfoService.CgroupResult(Optional.of(80217L), false))),
                        Map.entry(
                                "cpu.stat.system_usec",
                                List.of(new CGroupV2InfoService.CgroupResult(Optional.of(235204L), false))),
                        Map.entry(
                                "cpu.stat.core_sched.force_idle_usec",
                                List.of(new CGroupV2InfoService.CgroupResult(Optional.of(0L), false))),
                        Map.entry(
                                "cpu.stat.nr_periods",
                                List.of(new CGroupV2InfoService.CgroupResult(Optional.of(0L), false))),
                        Map.entry(
                                "cpu.stat.nr_throttled",
                                List.of(new CGroupV2InfoService.CgroupResult(Optional.of(0L), false))),
                        Map.entry(
                                "cpu.stat.throttled_usec",
                                List.of(new CGroupV2InfoService.CgroupResult(Optional.of(0L), false))),
                        Map.entry(
                                "cpu.stat.nr_bursts",
                                List.of(new CGroupV2InfoService.CgroupResult(Optional.of(0L), false))),
                        Map.entry(
                                "cpu.stat.burst_usec",
                                List.of(new CGroupV2InfoService.CgroupResult(Optional.of(0L), false)))));
        // TODO: it's not testing memory stats :(
    }
}
