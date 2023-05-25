describe('Jungle App', () => {
  it('Navigates from home page to product page on product click', () => {
    cy.visit('http://localhost:3000')
    cy.contains('Giant Tea').click();
    cy.url().should('eq', 'http://localhost:3000/products/1')
  });
});