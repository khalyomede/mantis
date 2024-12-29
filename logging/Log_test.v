import test { expect, Fake }
import logging { Log }
import logging.channel { File }
import os

const fake := Fake{}

fn test_it_logs_emergency_data_on_file() {
    log_file_path := "misc/mantis.log"

    os.rm(log_file_path) or {}

    defer {
        os.rm(log_file_path) or {}
    }

    mut log := Log{
        channel: File{
            path: log_file_path
        }
    }

    data := fake.sentence()

    log.emergency(data) or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[EMRG] ${data}")
}

fn test_it_logs_alert_data_on_file() {
    log_file_path := "misc/mantis.log"

    os.rm(log_file_path) or {}

    defer {
        os.rm(log_file_path) or {}
    }

    mut log := Log{
        channel: File{
            path: log_file_path
        }
    }

    data := fake.sentence()

    log.alert(data) or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[ALRT] ${data}")
}

fn test_it_logs_critical_data_on_file() {
    log_file_path := "misc/mantis.log"

    os.rm(log_file_path) or {}

    defer {
        os.rm(log_file_path) or {}
    }

    mut log := Log{
        channel: File{
            path: log_file_path
        }
    }

    data := fake.sentence()

    log.critical(data) or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[CRIT] ${data}")
}

fn test_it_logs_error_data_on_file() {
    log_file_path := "misc/mantis.log"

    os.rm(log_file_path) or {}

    defer {
        os.rm(log_file_path) or {}
    }

    mut log := Log{
        channel: File{
            path: log_file_path
        }
    }

    data := fake.sentence()

    log.error(data) or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[ERRO] ${data}")
}

fn test_it_logs_warning_data_on_file() {
    log_file_path := "misc/mantis.log"

    os.rm(log_file_path) or {}

    defer {
        os.rm(log_file_path) or {}
    }

    mut log := Log{
        channel: File{
            path: log_file_path
        }
    }

    data := fake.sentence()

    log.warning(data) or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[WARN] ${data}")
}

fn test_it_logs_notice_data_on_file() {
    log_file_path := "misc/mantis.log"

    os.rm(log_file_path) or {}

    defer {
        os.rm(log_file_path) or {}
    }

    mut log := Log{
        channel: File{
            path: log_file_path
        }
    }

    data := fake.sentence()

    log.notice(data) or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[NTCE] ${data}")
}

fn test_it_logs_info_data_on_file() {
    log_file_path := "misc/mantis.log"

    os.rm(log_file_path) or {}

    defer {
        os.rm(log_file_path) or {}
    }

    mut log := Log{
        channel: File{
            path: log_file_path
        }
    }

    data := fake.sentence()

    log.info(data) or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[INFO] ${data}")
}

fn test_it_logs_debug_data_on_file() {
    log_file_path := "misc/mantis.log"

    os.rm(log_file_path) or {}

    defer {
        os.rm(log_file_path) or {}
    }

    mut log := Log{
        channel: File{
            path: log_file_path
        }
    }

    data := fake.sentence()

    log.debug(data) or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[DBUG] ${data}")
}
