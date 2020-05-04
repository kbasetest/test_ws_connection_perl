use test_ws_connection_perl::test_ws_connection_perlImpl;

use test_ws_connection_perl::test_ws_connection_perlServer;
use Plack::Middleware::CrossOrigin;



my @dispatch;

{
    my $obj = test_ws_connection_perl::test_ws_connection_perlImpl->new;
    push(@dispatch, 'test_ws_connection_perl' => $obj);
}


my $server = test_ws_connection_perl::test_ws_connection_perlServer->new(instance_dispatch => { @dispatch },
				allow_get => 0,
			       );

my $handler = sub { $server->handle_input(@_) };

$handler = Plack::Middleware::CrossOrigin->wrap( $handler, origins => "*", headers => "*");
