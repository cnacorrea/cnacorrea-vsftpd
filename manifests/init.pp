class vsftpd (
	$anonymous_enable = $vsftpd::params::anonymous_enable,
) inherits vsftpd::params {
    include vsftpd::install, vsftpd::firewall, vsftpd::service, vsftpd::monit
    
    augeas { "vsftpd.conf":
		context => "/files/etc/vsftpd/vsftpd.conf",
		changes => [
    		"set anonymous_enable ${anonymous_enable}",
  		],
	}
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
