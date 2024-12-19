module translation

pub struct TranslateParams {
    pub:
        key string  @[required]
        lang Lang   @[required]
        gender Gender = .neutral
        count int = -1
        parameters map[string]string = {}  // Optional replacements with empty default
}
