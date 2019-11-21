module fidelizacao

-- classe fidelizacao que tem como atributo o tipo de fidelizacao, que varia com o percentual de boletos pagos
sig Fidelizacao {
	tipoFidelizacao: one TipoFidelizacao
}

-- classe cliente que tem como atributo boletos
sig Cliente {
	boletos: set Boleto,
	fidelizacao: lone TipoFidelizacao
}

-- classe boleto que tem como atributos a data de vencimento em string e se o boleto ja foi pago(1 ou 0)
sig Boleto {
	--vencimento:String,
	--pago:Int
}

-- classe abstrata dos tipos de fidelizacao
abstract sig TipoFidelizacao {
	cliente: one Cliente
}

--os tipos de fidelizacao, que extendem a classe TipoFidelização
sig Ouro, Prata, Bronze extends TipoFidelizacao {}

fact {
	no tipoFidelizacao
	-- nao devem existir fidelizacoes sem clientes
	all t:TipoFidelizacao | #t.cliente > 0
	--relacao eh bidirecional
	all t:TipoFidelizacao | (t.cliente.fidelizacao = t)
	#TipoFidelizacao = #Cliente
	--todo cliente tem boletos
	all c:Cliente | some c.boletos
}

assert nemTodoClienteEhBomPagador {
	all c:Cliente | lone c.fidelizacao
}

check nemTodoClienteEhBomPagador for 50

pred show[]{}
run show for 50
 
