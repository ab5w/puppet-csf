puppet-csf
======================
Puppet class to manage/configure CSF

#### Install CSF

    csf { 'install': }

#### Allow an IP

    csf { 'puppetmaster-001':
        type => 'allow',
        ip   => '192.168.1.100',
    }

#### Deny an IP

    csf { 'bad-person':
        type => 'deny',
        ip   => '192.168.1.101',
    }

#### Ignore an IP

    csf { 'google':
        type => 'ignore',
        ip   => '8.8.8.8',
    }

#### Specify the ports allowed for TCP in.

    csf::tcp { 'in':
        ports => [ '80', '443', '22' ],
    }

#### Specify the ports allowed for TCP out.

    csf::tcp { 'out':
        ports => [ '80' ,'443' ],
    }

#### Set a LFD option.

    csf::lf { 'smtpauth':
        value => '50',
    }
