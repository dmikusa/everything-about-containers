@import com.mikusa.cgi.cgroups.CGroupV2InfoService
@import java.util.List
@import java.util.Map
@import static com.mikusa.cgi.cgroups.TemplateUtils.*

@param Map<String, List<CGroupV2InfoService.CgroupResult>> cpuInfo
@param Map<String, List<CGroupV2InfoService.CgroupResult>> memoryInfo

<!DOCTYPE HTML>
<html>
<head>
    <title>Container Information</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" type="text/css" href="/css/styles.css" />
</head>
<body>
<h1>Container Information</h1>
@if (cpuInfo.isEmpty() && memoryInfo.isEmpty())
    <b>Unable to load container information.</b>
@else
    <h2>CPU Info</h2>
    <table>
        <tr>
            <th>Idle</th>
            <td>${cgroupResultToListString(cpuInfo.get("cpu.idle"))}</td>
        </tr>
        <tr>
            <th>Max</th>
            <td>${cgroupResultToListString(cpuInfo.get("cpu.max"))}</td>
        </tr>
        <tr>
            <th>Max Burst</th>
            <td>${cgroupResultToListString(cpuInfo.get("cpu.max.burst"))}</td>
        </tr>
        <tr>
            <th>Weight</th>
            <td>${cgroupResultToListString(cpuInfo.get("cpu.weight"))}</td>
        </tr>
    </table>

    <h2>CPU Stats</h2>
    <table>
        <tr>
            <th>System Time</th>
            <td>${cgroupResultToListString(cpuInfo.get("cpu.stat.system_usec"))}</td>
        </tr>
        <tr>
            <th>Usage Time</th>
            <td>${cgroupResultToListString(cpuInfo.get("cpu.stat.usage_usec"))}</td>
        </tr>
        <tr>
            <th>User Time</th>
            <td>${cgroupResultToListString(cpuInfo.get("cpu.stat.user_usec"))}</td>
        </tr>
        <tr>
            <th>Number of Bursts</th>
            <td>${cgroupResultToListString(cpuInfo.get("cpu.stat.nr_bursts"))}</td>
        </tr>
        <tr>
            <th>Burst Time</th>
            <td>${cgroupResultToListString(cpuInfo.get("cpu.stat.burst_usec"))}</td>
        </tr>
        <tr>
            <th>Number of Periods</th>
            <td>${cgroupResultToListString(cpuInfo.get("cpu.stat.nr_periods"))}</td>
        </tr>
        <tr>
            <th>Number of Throttles</th>
            <td>${cgroupResultToListString(cpuInfo.get("cpu.stat.nr_throttled"))}</td>
        </tr>
        <tr>
            <th>Throttled Time</th>
            <td>${cgroupResultToListString(cpuInfo.get("cpu.stat.throttled_usec"))}</td>
        </tr>
    </table>

    <h2>Memory Info</h2>
    <table>
        <tr>
            <th>Current</th>
            <td>${cgroupResultToListString(memoryInfo.get("memory.current"))}</td>
        </tr>
        <tr>
            <th>High</th>
            <td>${cgroupResultToListString(memoryInfo.get("memory.high"))}</td>
        </tr>
        <tr>
            <th>Low</th>
            <td>${cgroupResultToListString(memoryInfo.get("memory.low"))}</td>
        </tr>
        <tr>
            <th>Max</th>
            <td>${cgroupResultToListString(memoryInfo.get("memory.max"))}</td>
        </tr>
        <tr>
            <th>Min</th>
            <td>${cgroupResultToListString(memoryInfo.get("memory.min"))}</td>
        </tr>
        <tr>
            <th>Peak</th>
            <td>${cgroupResultToListString(memoryInfo.get("memory.peak"))}</td>
        </tr>
        <tr>
            <th>Swap Current</th>
            <td>${cgroupResultToListString(memoryInfo.get("memory.swap.current"))}</td>
        </tr>
        <tr>
            <th>Swap High</th>
            <td>${cgroupResultToListString(memoryInfo.get("memory.swap.high"))}</td>
        </tr>
        <tr>
            <th>Swap Max</th>
            <td>${cgroupResultToListString(memoryInfo.get("memory.swap.max"))}</td>
        </tr>
        <tr>
            <th>Swap Peak</th>
            <td>${cgroupResultToListString(memoryInfo.get("memory.swap.peak"))}</td>
        </tr>
    </table>
@endif

</body>
</html>