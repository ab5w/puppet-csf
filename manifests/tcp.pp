#
#
#
define csf::tcp ($ports) {

    Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/', '/usr/local/bin/' ] }

    if ($name == 'in') {

        if (is_array($ports)) {

            $ports_in = join($ports, ',')
            $exec_name = join($ports, '-')

            $tcp_in = "TCP_IN = \"${ports_in}\""

            exec { "TCP_IN-${exec_name}":
                command => "sed -i 's/TCP_IN = \".*/${tcp_in}/' /etc/csf/csf.conf && csf -r",
                unless  => "grep \'${tcp_in}\' /etc/csf/csf.conf",
                onlyif  => 'test -e /etc/csf/csf.conf',
            }

        } else {

            fail('The port(s) need to be in array format.')

        }

    }

    if ($name == 'out') {

        if (is_array($ports)) {

            $ports_out = join($ports, ',')
            $exec_name = join($ports, '-')

            $tcp_out = "TCP_OUT = \"${ports_out}\""

            exec { "TCP_OUT-${exec_name}":
                command => "sed -i 's/TCP_OUT = \".*/${tcp_out}/' /etc/csf/csf.conf && csf -r",
                unless  => "grep \'${tcp_out}\' /etc/csf/csf.conf",
                onlyif  => 'test -e /etc/csf/csf.conf',
            }

        } else {

            fail('The port(s) need to be in array format.')

        }

    }

}