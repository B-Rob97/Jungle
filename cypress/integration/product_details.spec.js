describe('Product Page Tests', () => {

  beforeEach(() => {
    cy.visit('/')
  
  })
  
    it("Should open the product page when clicking on a product", () => {
      cy.get(".products article").should("be.visible");
      cy.get(".products article img").first().click();
    });
  

  })
  