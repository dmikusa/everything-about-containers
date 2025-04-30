package com.mikusa.cgi.cgroups;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;
import java.util.Optional;
import org.junit.jupiter.api.Test;

class TemplateUtilsTest {

    @Test
    void shouldReturnEmptyBracketsWhenListIsNull() {
        String result = TemplateUtils.cgroupResultToListString(null);
        assertThat(result).isEqualTo("[]");
    }

    @Test
    void shouldReturnEmptyBracketsWhenListIsEmpty() {
        String result = TemplateUtils.cgroupResultToListString(List.of());
        assertThat(result).isEqualTo("[]");
    }

    @Test
    void shouldReturnMaxWhenResultIsMax() {
        List<CGroupV2InfoService.CgroupResult> input =
                List.of(new CGroupV2InfoService.CgroupResult(Optional.empty(), true));

        String result = TemplateUtils.cgroupResultToListString(input);

        assertThat(result).isEqualTo("max");
    }

    @Test
    void shouldReturnValueWhenResultHasValue() {
        List<CGroupV2InfoService.CgroupResult> input =
                List.of(new CGroupV2InfoService.CgroupResult(Optional.of(123L), false));

        String result = TemplateUtils.cgroupResultToListString(input);

        assertThat(result).isEqualTo("123");
    }

    @Test
    void shouldJoinMultipleValuesWithComma() {
        List<CGroupV2InfoService.CgroupResult> input = List.of(
                new CGroupV2InfoService.CgroupResult(Optional.of(100L), false),
                new CGroupV2InfoService.CgroupResult(Optional.empty(), true),
                new CGroupV2InfoService.CgroupResult(Optional.of(200L), false));

        String result = TemplateUtils.cgroupResultToListString(input);

        assertThat(result).isEqualTo("100, max, 200");
    }
}
