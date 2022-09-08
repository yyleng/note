use clap::{Arg, Command};

pub fn build() -> Command<'static> {
    Command::new("clap_test")
        // 版本
        .version("0.1.0")
        // 描述
        .about("this is clap test description")
        // 作者
        .author("aico")
        // 必要
        .arg(
            Arg::with_name("jjj")
                .default_value("default value")
                .multiple(true)
                .help("An argument")

        )
        // Options
        .arg(
            Arg::with_name("flag")
                .long("flag")
                .short('f')
                .takes_value(true)
                .number_of_values(1)
                .possible_values(&["a", "b", "c"])
                .default_value("a")
                .help("flag description"),
        )
        // 子命令
        .subcommands(vec![
                     // 相当于递归创建命令
                     // arg 配置同上
            Command::new("sub1")
                .about("sub1 description")
                .arg(
                    Arg::with_name("sub1_arg")
                        .default_value("default value")
                        .multiple(true)
                        .help("An argument")
                ),
            Command::new("sub2")
                .about("sub2 description")
                .arg(
                    Arg::with_name("sub2_arg")
                        .default_value("default value")
                        .multiple(true)
                        .help("An argument")
                ),
        ])
        // 末尾描述
        .after_help("this is clap test description after help")
}
