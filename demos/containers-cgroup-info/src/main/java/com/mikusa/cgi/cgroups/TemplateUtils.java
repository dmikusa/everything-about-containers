package com.mikusa.cgi.cgroups;

import java.util.List;

public class TemplateUtils {
    private TemplateUtils() {}

    public static String cgroupResultToListString(List<CGroupV2InfoService.CgroupResult> cgroupResult) {
        if (cgroupResult == null || cgroupResult.isEmpty()) {
            return "[]";
        }

        return String.join(
                ", ",
                cgroupResult.stream()
                        .map(c -> (c.max()) ? "max" : c.value().get().toString())
                        .toList());
    }
}
