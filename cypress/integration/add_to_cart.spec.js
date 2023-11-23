describe("Add to cart", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("Adds a product to the cart and the cart is increased by 1", () => {
    cy.contains("My Cart (0)");
    cy.contains("Add").first().click({ force: true });
    cy.contains("My Cart (1)");
  });
});