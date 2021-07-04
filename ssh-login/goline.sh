#!/usr/bin/expect
set timeout 10
spawn ssh tanxiaoshan@jumpserver.doushen-int.com -p2222
expect {
    "*password*" {
        send "Txs19910414\n";
        exp_continue;
    }
    "*JumpServer*" {
        send "p\r";
        exp_continue;
    }
}    
interact