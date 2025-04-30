package com.mikusa.cgi.cgroups;

import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/cgroups-v2")
public class CGroupInfoController {
    private final CGroupV2InfoService cGroupV2InfoService;

    public CGroupInfoController(CGroupV2InfoService cGroupV2InfoService) {
        this.cGroupV2InfoService = cGroupV2InfoService;
    }

    @GetMapping
    public String index(Model model, HttpServletResponse response) {
        model.addAttribute("cpuInfo", cGroupV2InfoService.loadFiles(CGroupV2InfoService.CGROUP_CPU_PATHS));
        model.addAttribute("memoryInfo", cGroupV2InfoService.loadFiles(CGroupV2InfoService.CGROUP_MEMORY_PATHS));
        return "cgroups-v2-info/index";
    }
}
