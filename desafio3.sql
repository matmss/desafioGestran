SELECT  prod.nome, prod.preco, forn.nome
FROM    produto prod
INNER JOIN fornecedores forn ON prod.fornecedores_id = forn.id

SELECT  cli.nome, cli.telefone, vende.nome, form.forma_pagamento
FROM    cliente cli
INNER JOIN venda vend ON cli.id = vend.cliente_id
INNER JOIN vendedor vende ON vende.id = vend.vendedor_id
INNER JOIN pagamento pag ON pag.id = vend.pagamento_id
