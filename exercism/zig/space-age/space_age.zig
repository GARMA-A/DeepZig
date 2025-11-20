pub const Planet = enum {
    mercury,
    earth,
    venus,
    mars,
    jupiter,
    saturn,
    uranus,
    neptune,

    pub fn age(self: Planet, seconds: usize) f64 {
        const sec: f64 = @floatFromInt(seconds);
        const earthYear = sec / 31_557_600.0;
        return switch (self) {
            .mercury => earthYear / 0.2408467,
            .earth => earthYear / 1.0,
            .venus => earthYear / 0.61519726,
            .mars => earthYear / 1.8808158,
            .jupiter => earthYear / 11.862615,
            .saturn => earthYear / 29.447498,
            .uranus => earthYear / 84.016846,
            .neptune => earthYear / 164.79132,
        };
    }
};
