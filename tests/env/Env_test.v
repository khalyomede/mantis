// tests/env/env_test.v
import mantis.test { expect }
import mantis.env { Env }

fn test_can_load_env_file() {
    mut environment := Env{
        file: $embed_file("misc/.env")
    }

    expect(environment.get('APP_NAME')!).to_be_equal_to('Mantis')
}

fn test_can_use_cached_values() {
    mut environment := Env{
        file: $embed_file("misc/.env")
    }

    // First access parses
    first := environment.get('APP_NAME')!
    // Second should use cache
    second := environment.get('APP_NAME')!

    expect(first).to_be_equal_to(second)
}

fn test_handles_missing_values() {
    mut environment := Env{
        file: $embed_file("misc/.env")
    }

    value := environment.get('DOES_NOT_EXIST') or {
        'default'
    }

    expect(value).to_be_equal_to('default')
}

fn test_ignores_comments() {
    mut environment := Env{
        file: $embed_file("misc/.env")
    }

    expect(environment.get('AFTER_COMMENT')!).to_be_equal_to('value')
}
