use serde::{Deserialize, Serialize};
mod command;

const CONFIG_FILE: &str = "config.yaml";
const CONFIG_DIR: &str = "serde";

#[derive(Debug, Serialize, Deserialize)]
struct Foo {
    name: Option<Vec<String>>,
    id: Option<u64>,
}

impl Foo {
    fn new() -> Self {
        Foo {
            name: None,
            id: None,
        }
    }

    fn config_file_path() -> Option<std::path::PathBuf> {
        use xdg::BaseDirectories;
        match BaseDirectories::with_prefix(CONFIG_DIR) {
            Ok(dirs) => Some(dirs.get_config_home()),
            Err(_) => None,
        }
    }
}

impl Default for Foo {
    fn default() -> Self {
        // 在默认路径下读取配置文件
        if let Some(path) = Self::config_file_path() {
            let path = path.join(CONFIG_FILE);
            println!("config file path: {:?}", path);
            if let Ok(file) = std::fs::File::open(path) {
                if let Ok(config) = serde_yaml::from_reader(file) {
                    return config;
                }
            }
        }

        // 如果默认配置目录不存在配置文件, 则使用默认配置
        const DEFAULT_CONFIG: &str = r#"
            name:
              - default1
              - default2
            id: 12
                     "#;
        serde_yaml::from_str::<Foo>(DEFAULT_CONFIG).unwrap()
    }
}

fn main() {
    let matches = command::build().get_matches();
    // 反序列化
    // from different type of files
    let config: Foo = if matches.is_present("config-file") {
        let config_file = matches.value_of("config-file").unwrap();
        match std::fs::read(config_file) {
            Ok(content) => {
                // json
                if config_file.ends_with(".json") {
                    serde_json::from_str::<Foo>(&String::from_utf8_lossy(&content)).unwrap()
                // yaml
                } else if config_file.ends_with(".yaml") {
                    serde_yaml::from_str::<Foo>(&String::from_utf8_lossy(&content)).unwrap()
                // toml
                } else if config_file.ends_with(".toml") {
                    toml::from_str::<Foo>(&String::from_utf8_lossy(&content)).unwrap()
                } else {
                    panic!("Unsupported file type");
                }
            }
            Err(e) => {
                panic!("read config file error: {}", e)
            }
        }
    } else {
        // default config
        Foo::default()
    };
    println!("{:?}", config);
    // 序列化
    let foo = Foo {
        name: Some(vec!["foo".to_string(), "bar".to_string()]),
        id: Some(32),
    };
    let json = serde_json::to_string(&foo).unwrap();
    println!("{}", json);
}
