# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.1] - 2020-10-29
### Added
- Password rule with exvalidate regex with test.
- Password rule with custom regex with test.
- IpV4 rule with test.
- Nullable rule with test.
- Option to show error messages or to show atom messages in config file.

### Changed
- Refactor all test files.

## [0.1.0] - 2020-04-##
### Added
- Middleware for validation plug routes get and post.
- Plain text and json plug function errors.
- Custom function errors in plug middleware.
- Validation data one by one.
- Only get the first error found.
- Interface to control validation rules.
- Accepted rule for validate 1, "true", "on" or yes.
- Between rule accepts string, numerics, array and tuples.
- Default rule control.
- Email rule control.
- In rule accepts string, number and lists.
- Length rule accepts string, lists and tuples.
- Max_length rule accepts string, tuple and list.
- Min_length rule accepts string, tuple and list.
- Required rule.
- Type rule for control types in elixir [string, list, map, tuple, number, integer and float].
- Matrix messages errors.
- Parsing atom errors to messages string errors.
- Return friendly errors.
