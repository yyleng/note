use clap::{Arg, Command};

pub fn build() -> Command<'static> {
    Command::new("serde")
        .about("serde test")
        .arg(
            Arg::new("config-file")
            .short('f')
            .takes_value(true)
            .number_of_values(1)
        )
}
