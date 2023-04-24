namespace backend.Utils;

public static class Extensions
{
    public static DateOnly ToDateOnly(this DateTime dateTime)
        => DateOnly.FromDateTime(dateTime);

    public static DateOnly ToDateOnly(this String date)
        => DateTime.ParseExact(date, "yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture).ToDateOnly();
}
