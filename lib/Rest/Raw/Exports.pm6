use v6.c;

unit package Rest::Raw::Exports;

our @rest-exports is export;

BEGIN {
  @rest-exports = <
    Rest::Raw::Definitions
    Rest::Raw::Enums
  >;
}
