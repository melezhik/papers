# app.psgi
use Kelp::Less;
 
get '/database-status' => sub { 'database is running!' };

post '/login' => sub { 

    my $self = shift; 

    if ( $self->param('username') eq 'alex' and $self->param('password') eq '123456' ){

        'Hello user! This is profile page';

    } else {

        return $self->res->render_401 
    }

};

run;
