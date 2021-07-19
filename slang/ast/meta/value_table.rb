ValueTable = Hash.new 
ValueTable['PRINT'] = Token::TOK_PRINT
ValueTable['PRINTLINE'] = Token::TOK_PRINTLN
ValueTable['FALSE'] = Token::TOK_BOOL_FALSE
ValueTable['TRUE'] = Token::TOK_BOOL_TRUE
ValueTable['STRING'] = Token::TOK_VAR_STRING
ValueTable['BOOLEAN'] = Token::TOK_VAR_BOOL
ValueTable['NUMERIC'] = Token::TOK_VAR_NUMBER