mod command;

fn main() {
    let matches = command::build().get_matches();
    if matches.is_present("flag") {
        let flag = matches.value_of("flag").expect("invalid flag");
        println!("flag: {}", flag);
    }
    if let Some(arg) = matches.value_of("jjj") {
        println!("arg: {}", arg);
    }

    if let Some(sub_matches) = matches.subcommand_matches("sub1") {
        if let Some(sub_arg) = sub_matches.value_of("sub1_arg") {
            println!("sub_arg: {}", sub_arg);
        }
    }
}
