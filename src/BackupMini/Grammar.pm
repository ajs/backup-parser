use v6;

grammar BackupMini::Grammar;

rule TOP { <stmts> }
rule stmts { <stmt>* % "\n" }
rule stmt { 'at' <date> <time> <backup-type> <path> }

rule date {
	<list-of-dates> |
	<raw-date>
}
rule time {
	<list-of-times> |
	<raw-time>
}
rule backup-type { 'full', 'incremental' }
rule path { <string> }

rule list-of-dates { '[' ~ ']' <bare-list-of-dates> }
rule bare-list-of-dates { <raw-date>+ % ',' }
rule list-of-times { '[' ~ ']' <bare-list-of-times> }
rule bare-list-of-times { <raw-time>+ % ',' }

rule raw-date { <dow> | <iso-date> | '*' }
token dow {
	'monday' | 'tuesday' | 'wednesday' | 'thursday' | 'friday' |
		'saturday' | 'sunday' |
	'mon' | 'tue' | 'tues' | 'wed' | 'weds' | 'thu' | 'thur' |
		'fri' | 'sat' | 'sun'
}
token iso-date { <year> '-' <month> '-' <day> }
token year { \d ** 4 }
token month { \d ** 2 }
token day { \d ** 2 }

rule raw-time { <clock-time> | '*' }
rule clock-time { <hms> [ 'am' | 'pm' ]? }
token hms { <hour> [ ':' <minute> [ ':' <second> ]? ]? }
token hour { \d ** 1..2 }
token minute { \d ** 2 }
token second { \d ** 2 }
