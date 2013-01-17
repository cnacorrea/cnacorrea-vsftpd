class vsftpd {
    include vsftpd::install, vsftpd::config, vsftpd::firewall, vsftpd::service, vsftpd::monit
}

class vsftpd::monit {
    File {
        owner => "root",
        group => "root",
        mode => 0600,
    }
    
    file { "/etc/monit.d/vsftpd.conf":
        ensure  => present,
        content => template("vsftpd/monit.erb"),
        require => Class["monit::install"],
        notify  => Class["monit::service"],
    }
}
