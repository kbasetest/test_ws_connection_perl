package test_ws_connection_perl::test_ws_connection_perlImpl;
use strict;
use Bio::KBase::Exceptions;
# Use Semantic Versioning (2.0.0-rc.1)
# http://semver.org 
our $VERSION = '0.0.1';
our $GIT_URL = '';
our $GIT_COMMIT_HASH = '87e297c2efe8f3b33b149a174a87a4d84208ca90';

=head1 NAME

test_ws_connection_perl

=head1 DESCRIPTION

A KBase module: test_ws_connection_perl

=cut

#BEGIN_HEADER
use Bio::KBase::AuthToken;
use installed_clients::KBaseReportClient;
use installed_clients::WorkspaceClient;
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
    my $wsurl = $cfg->val('workspace-url');

    $self->{scratch} = $scratch;
    $self->{callbackURL} = $callbackURL;
    $self->{wsURL} = $wsurl;
    #END_CONSTRUCTOR

    if ($self->can('_init_instance'))
    {
	$self->_init_instance();
    }
    return $self;
}

=head1 METHODS



=head2 get_ws_info

  $wsinfo = $obj->get_ws_info($wsid)

=over 4

=item Parameter and return types

=begin html

<pre>
$wsid is an int
$wsinfo is an UnspecifiedObject, which can hold any non-null object

</pre>

=end html

=begin text

$wsid is an int
$wsinfo is an UnspecifiedObject, which can hold any non-null object


=end text



=item Description

Returns information about a workspace as per the get_workspace_info method.

=back

=cut

sub get_ws_info
{
    my $self = shift;
    my($wsid) = @_;

    my @_bad_arguments;
    (!ref($wsid)) or push(@_bad_arguments, "Invalid type for argument \"wsid\" (value was \"$wsid\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to get_ws_info:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_ws_info');
    }

    my $ctx = $test_ws_connection_perl::test_ws_connection_perlServer::CallContext;
    my($wsinfo);
    #BEGIN get_ws_info
    my $ws = new installed_clients::WorkspaceClient($self->{wsURL}, token=>$ctx->token());
    $wsinfo = $ws->get_workspace_info({id => $wsid})
    #END get_ws_info
    my @_bad_returns;
    (defined $wsinfo) or push(@_bad_returns, "Invalid type for return variable \"wsinfo\" (value was \"$wsinfo\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to get_ws_info:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_ws_info');
    }
    return($wsinfo);
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



=cut

1;
