class vsftpd (
	$anonymous_enable = $vsftpd::params::anonymous_enable,
	$local_enable = $vsftpd::params::local_enable,
	$write_enable = $vsftpd::params::write_enable,
	$local_umask = $vsftpd::params::local_umask,
	$anon_upload_enable = $vsftpd::params::anon_upload_enable,
	$anon_mkdir_write_enable = $vsftpd::params::anon_mkdir_write_enable,
	$dirmessage_enable = $vsftpd::params::dirmessage_enable,
	$xferlog_enable = $vsftpd::params::xferlog_enable,
	$connect_from_port_20 = $vsftpd::params::connect_from_port_20,
	$xferlog_std_format = $vsftpd::params::xferlog_std_format,
	$ftpd_banner = $vsftpd::params::ftpd_banner,
	$chroot_local_user = $vsftpd::params::chroot_local_user,
	$chroot_list_enable = $vsftpd::params::chroot_list_enable,
	$chroot_list_file = $vsftpd::params::chroot_list_file,
	$listen = $vsftpd::params::listen,
	$pam_service_name = $vsftpd::params::pam_service_name,
	$userlist_enable = $vsftpd::params::userlist_enable,
	$tcp_wrappers = $vsftpd::params::tcp_wrappers,
) inherits vsftpd::params {
    include vsftpd::install, vsftpd::firewall, vsftpd::service, vsftpd::monit
    
    augeas { "vsftpd.conf":
		context => "/files/etc/vsftpd/vsftpd.conf",
		changes => [
    		"set anonymous_enable ${anonymous_enable}",
			"set local_enable ${local_enable}",
			"set write_enable ${write_enable}",
			"set local_umask ${local_umask}",
			"set anon_upload_enable ${anon_upload_enable}",
			"set anon_mkdir_write_enable ${anon_mkdir_write_enable}",
			"set dirmessage_enable ${dirmessage_enable}",
			"set xferlog_enable ${xferlog_enable}",
			"set connect_from_port_20 ${connect_from_port_20}",
			"set xferlog_std_format ${xferlog_std_format}",
			"set ftpd_banner ${ftpd_banner}",
			"set chroot_local_user ${chroot_local_user}",
			"set chroot_list_enable ${chroot_list_enable}",
			"set chroot_list_file ${chroot_list_file}",
			"set listen ${listen}",
			"set pam_service_name ${pam_service_name}",
			"set userlist_enable ${userlist_enable}",
			"set tcp_wrappers ${tcp_wrappers}",
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
