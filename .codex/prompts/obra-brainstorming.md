---
description: Refinar ideias e designs com perguntas guiadas, opções e validação incremental
argument-hint: [CONTEXTO="<descrição do projeto>"]
---

Use este prompt quando estiver criando ou desenvolvendo antes de implementar. Segue o processo:

1. **Entenda o contexto**: revise arquivos, docs, commits e o CONTEXTO fornecido.
2. **Pergunte um ponto por vez**: formule perguntas curtas (preferencialmente com alternativas) para explorar propósito, restrições e critérios de sucesso.
3. **Proponha abordagens**: apresente 2-3 opções de design/solução, destacando trade-offs e explicando qual delas recomenda e por quê.
4. **Apresente o design em seções**: escreva blocos de 200‑300 palavras cobrindo arquitetura, componentes, fluxo de dados, tratamento de erros e testes; depois de cada trecho, pergunte "Isso faz sentido até aqui?" e aguarde confirmação.
5. **Documente e posso seguir**: quando o design estiver validado, recomende escrever em `docs/plans/YYYY-MM-DD-<topico>-design.md`, use `superpowers:using-git-worktrees` para ambientes isolados e `superpowers:writing-plans` para planos detalhados.

**Princípios chave**
- Pergunte uma coisa por vez.
- Prefira perguntas de múltipla escolha.
- Elimine o supérfluo (YAGNI).
- Explore alternativas antes de decidir.
- Valide incrementalmente cada seção.
- Seja flexível e revise quando surgir dúvida.
