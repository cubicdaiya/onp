use std::cmp::max;

pub struct Diff {
    a: String,
    b: String,
    m: usize,
    n: usize,
}

pub fn build_diff(mut a: String, mut b: String) -> Diff {
    if a.chars().count() > b.chars().count() {
        let t = a;
        a = b;
        b = t;
    }
    return Diff {
        a: a.to_string(),
        b: b.to_string(),
        m: a.chars().count(),
        n: b.chars().count(),
    };
}

impl Diff {
    fn snake(&self, mut x: isize, mut y: isize) -> isize {
        while x >= 0
            && y >= 0
            && x < self.m as isize
            && y < self.n as isize
            && self.a.chars().nth(x as usize).unwrap() == self.b.chars().nth(y as usize).unwrap()
        {
            x = x + 1;
            y = y + 1;
        }

        return y;
    }

    pub fn ed(&self) -> usize {
        let offset: usize = self.m + 1;
        let delta: usize = self.n - self.m;
        let size = self.m + self.n + 3;
        let mut fp: Vec<isize> = vec![-1; size];

        let mut p: usize = 0;
        loop {
            let mut k = offset - p;
            while k <= delta + offset - 1 {
                let y = max(fp[k - 1] + 1, fp[k + 1]);
                fp[k] = self.snake(y - (k as isize) + (offset as isize), y);
                k = k + 1;
            }
            let mut l = delta + p;
            while l >= delta + 1 {
                let y = max(fp[l + offset - 1] + 1, fp[l + 1 + offset]);
                fp[l + offset] = self.snake(y - (l as isize), y);
                l = l - 1;
            }

            let y = max(fp[delta + offset - 1] + 1, fp[delta + 1 + offset]);
            fp[delta + offset] = self.snake(y - (delta as isize), y);

            if fp[delta + offset] >= (self.n as isize) {
                break;
            }
            p = p + 1;
        }
        return delta + 2 * p;
    }
}
