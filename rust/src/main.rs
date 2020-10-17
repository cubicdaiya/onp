use rust::diff;
use std::env::args;

fn main() {
    let args: Vec<String> = args().collect();

    if args.len() < 3 {
        println!("few arguments");
        std::process::exit(1);
    }

    let a = &args[1];
    let b = &args[2];

    println!("{}", a);
    println!("{}", b);

    let d = diff::build_diff(a.to_string(), b.to_string());

    println!("editdistance: {}", d.ed());
}
