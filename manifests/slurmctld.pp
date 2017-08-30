################################################################################
# Time-stamp: <Wed 2017-08-30 13:50 svarrette>
#
# File::      <tt>slurmctld.pp</tt>
# Author::    UL HPC Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2017 UL HPC Team
# License::   Apache-2.0
#
# ------------------------------------------------------------------------------
# == Class: slurm::slurmctld
#
# The main helper class specializing the main slurm class for setting up a
# Slurmctld daemon aka the slurm controller
#
# === Warnings
#
# /!\ Always respect the style guide available here[http://docs.puppetlabs.com/guides/style_guide]
#
# [Remember: No empty lines between comments and class definition]
#
class slurm::slurmctld inherits slurm
{

  File <| tag == 'slurm::configfile' |> {
    notify +> Service['slurmctld'],
  }

  service { 'slurmctld':
    ensure     => ($slurm::ensure == 'present'),
    enable     => ($slurm::ensure == 'present'),
    name       => $slurm::params::controller_servicename,
    pattern    => $slurm::params::controller_processname,
    hasrestart => $slurm::params::hasrestart,
    hasstatus  => $slurm::params::hasstatus,
  }
}