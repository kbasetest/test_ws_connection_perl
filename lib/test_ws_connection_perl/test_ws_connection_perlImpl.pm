package test_ws_connection_perl::test_ws_connection_perlImpl;
use strict;
use Bio::KBase::Exceptions;
# Use Semantic Versioning (2.0.0-rc.1)
# http://semver.org 
our $VERSION = '0.0.1';
our $GIT_URL = '';
our $GIT_COMMIT_HASH = '';

=head1 NAME

test_ws_connection_perl

=head1 DESCRIPTION

A KBase module: test_ws_connection_perl

=cut

#BEGIN_HEADER
use Bio::KBase::AuthToken;
use installed_clients::KBaseReportClient;
use Config::IniFiles;
#END_HEADER

sub new
{
    my($class, @args) = @_;
    my $self = {
    };
    bless $self, $class;
    #BEGIN_CONSTRUCTOR
    my $config_file = $ENV{ KB_DEPLOYMENT_CONFIG };
    my $cfg = Config::IniFiles->new(-file=>$config_file);
    my $scratch = $cfg->val('test_ws_connection_perl', 'scratch');
    my $callbackURL = $ENV{ SDK_CALLBACK_URL };

    $self->{scratch} = $scratch;
    $self->{callbackURL} = $callbackURL;
    #END_CONSTRUCTOR

    if ($self->can('_init_instance'))
    {
	$self->_init_instance();
    }
    return $self;
}

=head1 METHODS



=head2 run_test_ws_connection_perl

  $output = $obj->run_test_ws_connection_perl($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a reference to a hash where the key is a string and the value is an UnspecifiedObject, which can hold any non-null object
$output is a test_ws_connection_perl.ReportResults
ReportResults is a reference to a hash where the following keys are defined:
	report_name has a value which is a string
	report_ref has a value which is a string

</pre>

=end html

=begin text

$params is a reference to a hash where the key is a string and the value is an UnspecifiedObject, which can hold any non-null object
$output is a test_ws_connection_perl.ReportResults
ReportResults is a reference to a hash where the following keys are defined:
	report_name has a value which is a string
	report_ref has a value which is a string


=end text



=item Description

This example function accepts any number of parameters and returns results in a KBaseReport

=back

=cut

sub run_test_ws_connection_perl
{
    my $self = shift;
    my($params) = @_;

    my @_bad_arguments;
    (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument \"params\" (value was \"$params\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to run_test_ws_connection_perl:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'run_test_ws_connection_perl');
    }

    my $ctx = $test_ws_connection_perl::test_ws_connection_perlServer::CallContext;
    my($output);
    #BEGIN run_test_ws_connection_perl
    my $repcli = installed_clients::KBaseReportClient->new($self->{callbackURL});
    my $report = $repcli->create({
        workspace_name => $params->{workspace_name},
        report => {
            text_message => $params->{parameter_1},
            objects_created => []
        }
    });

    my $output = {
        report_name => $report->{name},
        report_ref => $report->{ref}
    };
    #END run_test_ws_connection_perl
    my @_bad_returns;
    (ref($output) eq 'HASH') or push(@_bad_returns, "Invalid type for return variable \"output\" (value was \"$output\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to run_test_ws_connection_perl:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'run_test_ws_connection_perl');
    }
    return($output);
}




=head2 status 

  $return = $obj->status()

=over 4

=item Parameter and return types

=begin html

<pre>
$return is a string
</pre>

=end html

=begin text

$return is a string

=end text

=item Description

Return the module status. This is a structure including Semantic Versioning number, state and git info.

=back

=cut

sub status {
    my($return);
    #BEGIN_STATUS
    $return = {"state" => "OK", "message" => "", "version" => $VERSION, "git_url" => $GIT_URL, "git_commit_hash" => $GIT_COMMIT_HASH};
    #END_STATUS
    return($return);
}

=head1 TYPES



=head2 ReportResults

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
report_name has a value which is a string
report_ref has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
report_name has a value which is a string
report_ref has a value which is a string


=end text

=back



=cut

1;
