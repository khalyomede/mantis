import test { expect }
import logging { Log }
import logging.channel { File }
import os

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

    log.emergency("test") or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[EMRG] test")
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

    log.alert("test") or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[ALRT] test")
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

    log.critical("test") or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[CRIT] test")
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

    log.error("test") or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[ERRO] test")
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

    log.warning("test") or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[WARN] test")
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

    log.notice("test") or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[NTCE] test")
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

    log.info("test") or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[INFO] test")
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

    log.debug("test") or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("[DBUG] test")
}
