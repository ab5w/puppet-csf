#
#
#
define csf::lf ($value) {

    Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/', '/usr/local/bin/' ] }

    $lf_name = upcase($name)

    $lf_value = "LF_${lf_name} = \"${value}\""

    exec { "LF_${lf_name}":
        command => "sed -i 's/LF_${lf_name} = \".*/${lf_value}/' /etc/csf/csf.conf && csf -r",
        unless  => "grep \'${lf_value}\' /etc/csf/csf.conf",
        onlyif  => "test -e /etc/csf/csf.conf && grep 'LF_${lf_name}' /etc/csf/csf.conf",
    }

}