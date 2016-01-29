#!/usr/bin/perl

use Mojolicious::Lite;

get '/' => {text => 'I very ♥ Mojolicious!'};

app->start;
