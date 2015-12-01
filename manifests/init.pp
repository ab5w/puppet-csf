#
#
#
define csf ($type,$ip) {

    Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/', '/usr/local/bin/' ] }

    if ($name == 'install') {

        exec { 'wget-csf':
            cwd     => '/usr/src',
            command => 'wget https://download.configserver.com/csf.tgz',
            creates => '/usr/src/csf.tgz',
        } ->

        exec { 'extract-csf':
            cwd     => '/usr/src',
            command => 'mkdir -p csf && tar -xzf csf.tgz -C csf --strip-components 1',
            creates => '/usr/src/csf/install.sh',
        } ->

        exec { 'install-csf':
            command => '/usr/src/csf/install.sh',
            creates => '/usr/sbin/csf',
        }

    }

    if ($type == 'allow') {

        if ($ip == undef) { fail('ip is not defined.') }

        exec { "allow-${ip}":
            command => "csf -a ${ip} '${name}'",
            unless  => "grep -w \"${ip}\" /etc/csf/csf.allow",
            onlyif  => 'test -x /usr/sbin/csf'
        }

    }

    if ($type == 'deny') {

        if ($ip == undef) { fail('ip is not defined.') }

        exec { "deny-${ip}":
            command => "csf -d ${ip} '${name}'",
            unless  => "grep -w \"${ip}\" /etc/csf/csf.deny",
            onlyif  => 'test -x /usr/sbin/csf'
        }

    }

    if ($type == 'ignore') {

        if ($ip == undef) { fail('ip is not defined.') }

        exec { "ignore-${ip}":
            command => "echo \"${ip} #${name}\" >> /etc/csf/csf.ignore && csf -r",
            unless  => "grep -w \"${ip}\" /etc/csf/csf.ignore",
            onlyif  => 'test -x /usr/sbin/csf',
        }

    }

}