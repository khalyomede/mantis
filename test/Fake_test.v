import test { expect, Fake }

const fake := Fake{}

fn test_it_generates_person_first_name() {
    expect(fake.person.first_name()).to_not_be_empty()
}

fn test_it_generates_person_last_name() {
    expect(fake.person.last_name()).to_not_be_empty()
}

fn test_it_generates_sentence() {
    expect(fake.sentence()).to_not_be_empty()
}

fn test_it_generates_primary_key() {
    expect(fake.database.primary_key()).to_be_greater_than(0)
}

fn test_it_can_generate_integer_between_range() {
    expect(fake.integer.between(0, test.max_int)).to_be_greater_or_equal_to(0)
}

fn test_it_can_generate_uuid_v4() {
    expect(fake.uuid.v4()).to_not_be_empty() // TODO; .to_match("UUID v4 regex")
}

fn test_it_can_generate_lang() {
    expect(fake.lang()).to_not_be_empty()
}

fn test_it_can_generate_two_character_country_code() {
    expect(fake.country.code.alpha2()).to_have_length(2)
}

fn test_it_can_generate_three_character_country_code() {
    expect(fake.country.code.alpha3()).to_have_length(3)
}

fn test_it_can_generate_negative_integer() {
    expect(fake.negative_integer()).to_be_negative()
}

fn test_it_can_generate_internet_base_url() {
    expect(fake.internet.base_url()).to_not_be_empty() // TODO: to_be_url()
}

fn test_it_can_generate_internet_protocol() {
    expect(fake.internet.protocol()).to_not_be_empty()
}

// TODO: add untested Fake functions.
