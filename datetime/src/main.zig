const std = @import("std");

test "datetime" {
    const nowTimestamp: u64 = @intCast(std.time.timestamp()); // timestamp は i64
    const epoch: std.time.epoch.EpochSeconds = std.time.epoch.EpochSeconds{ .secs = nowTimestamp };
    std.debug.print("{}\n", .{epoch});

    const epochDay = epoch.getEpochDay();
    const yearAndDay = epochDay.calculateYearDay();
    const monthDay = yearAndDay.calculateMonthDay();
    const daySeconds = epoch.getDaySeconds();

    const year = yearAndDay.year;
    const month = monthDay.month.numeric();
    const day = monthDay.day_index + 1;
    const hours = daySeconds.getHoursIntoDay();
    const minutes = daySeconds.getMinutesIntoHour();
    const seconds = daySeconds.getSecondsIntoMinute();

    const dtFmt = "{d}-{d:0>2}-{d:0>2} {d:0>2}:{d:0>2}:{d:0>2}";
    std.debug.print(dtFmt ++ "\n", .{ year, month, day, hours, minutes, seconds });
}
