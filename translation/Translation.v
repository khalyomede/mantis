module translation

pub struct Translation {
    pub:
        keys map[string]map[Lang]map[Gender]map[Countable]string
}
