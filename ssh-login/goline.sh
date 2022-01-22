#!/usr/bin/expect

set timeout 10
spawn ssh name@host -p2222
expect {
    "*password*" {
        send "******\n";
        exp_continue;
    }
    "*JumpServer*" {
        send "p\r";
        exp_continue;
    }
}    
interact