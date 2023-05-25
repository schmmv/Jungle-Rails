describe('Jungle App', () => {
  it('Add to cart button works upon clicking on a product on home page', () => {
    cy.visit('http://localhost:3000')
    cy.get('.products article').first().find('button').click({ force: true })
    .then(() => 
    cy.contains('Cart').contains('1')
    )
  });
});