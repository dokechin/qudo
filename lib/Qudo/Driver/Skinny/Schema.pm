package Qudo::Driver::Skinny::Schema;
use DBIx::Skinny::Schema;

install_table job => schema {
    pk 'id';
    columns qw/id func_id arg uniqkey enqueue_time grabbed_until/;

    trigger pre_insert => callback {
        my ($class, $args) = @_;
        $args->{enqueue_time} = time;
        $args->{grabbed_until} ||= 0;
    };
};

install_table func => schema {
    pk 'id';
    columns qw/id name/;
};

install_table exception_log => schema {
    pk 'id';
    columns qw/id func_id job_id message exception_time/;

    trigger pre_insert => callback {
        my ($class, $args) = @_;
        $args->{exception_time} = time;
    };
};

1;
