describe('Cart tests', () => {

  beforeEach(() => {
    cy.visit('/')
  
  })
  
    it("Add a item to cart on click", () => {
      cy.get(".products article").contains("Add").click({force: true});
    });

    it ("should increase the cart count", () => {
      cy.get(".products article").contains("Add").click({force: true});
      cy.contains('My Cart (1)').should('be.visible');
    });

    
    it("should not add a sold out item to the cart", () => {
      cy.get(".products article:contains('Sold Out')").within(() => {
        cy.contains("Add").click({force: true});
      });
      cy.contains('My Cart (0)').should('be.visible');
    });
    
  })