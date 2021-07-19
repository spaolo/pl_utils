#!/usr/bin/perl

open (PLIST,"-|","cat /proc/net/ip_vs_conn");
while (<PLIST>)
#TCP D9401E72 FB31 D4612044 0019 D4612040 0019 FIN_WAIT         24
{
#if ($_=~ /^(\w+) ([0-9A-Z]+) ([0-9A-Z]+) ([0-9A-Z]+) ([0-9A-Z]+) ([0-9A-Z]+) ([0-9A-Z]+) ([0-9A-Z]+) (\w+) (.+)/)
if ($_=~ /^(\w+) ([0-9|A-Z]+) ([0-9|A-Z]+) ([0-9|A-Z]+) ([0-9|A-Z]+) ([0-9|A-Z]+) ([0-9|A-Z]+) ([0-9|A-Z]+)\s+(.+)/)
        {print "$1 ";
        printf "%-22s ", conv_ip($2).":".conv_ip($3);
        printf "%-22s ", conv_ip($4).":".conv_ip($5);
        printf "%-22s ", conv_ip($6).":".conv_ip($7);
        print "\t".conv_ip($8).
                "\t$9\n"}

#else { print $_;}
}

sub conv_ip(){
$val=shift;
if (length($val) == 8)
        {@tmp=$val=~ /([0-9A-Z][0-9A-Z])([0-9A-Z][0-9A-Z])([0-9A-Z][0-9A-Z])([0-9A-Z][0-9A-Z])/;
        $ret='';
        for $tmpoct (@tmp)
                { $ret.=hex($tmpoct).".";}
        $ret=~s/\.$//;
        return $ret;
        }
else
        { #sprintf ("%X",$val);
        return hex($val);}
}
#0.0.0.0:0
#255.255.255.255:65535
