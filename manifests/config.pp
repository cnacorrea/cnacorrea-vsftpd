class vsftpd::config {
	file { "/etc/vsftpd/vsftpd.conf":
		ensure => present,
		owner => 'root',
		group => 'root',
		mode => 0600,
		content => template("vsftpd/vsftpd.conf.erb"),
		require => Class["vsftpd::install"],
		notify => Class["vsftpd::service"],
	}
	
	file { "/etc/vsftpd/chroot_list":
	    ensure => present,
		owner => 'root',
		group => 'root',
		mode => 0600,
		source => "puppet:///modules/vsftpd/chroot_list",
	}

    case $::selinux_current_mode {
        /(permissive|enforcing)/: {
	        selboolean { "ftp_home_dir":
	            persistent => true,
	            value => on,
	        }
	    }
	    default: {
	    }
    }
}
