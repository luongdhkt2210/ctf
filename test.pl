use strict;
use warnings;
use Net::Ping;

# Define the IP range you want to scan
my $start_ip = '172.30.0.1';
my $end_ip   = '172.30.0.10';

# Define the port you want to check
my $port = 3306;

# Create a new Net::Ping object
my $ping = Net::Ping->new("tcp", 2); # 2 seconds timeout

# Loop through the IP range and check for open port 3306
for (my $i = ip2long($start_ip); $i <= ip2long($end_ip); $i++) {
    my $ip = long2ip($i);
    if ($ping->ping($ip)) {
        if ($ping->ping($ip, $port)) {
            print "Port $port is open on IP: $ip\n";
        } else {
            print "Port $port is closed on IP: $ip\n";
        }
    } else {
        print "Host $ip is down\n";
    }
}

# Close the Net::Ping object
$ping->close();

# Helper functions to convert IP addresses to long integers and vice versa
sub ip2long {
    return unpack('N', pack('C4', split(/\./, $_[0])));
}

sub long2ip {
    return join('.', unpack('C4', pack('N', $_[0])));
}
