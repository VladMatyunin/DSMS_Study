SET SEARCH_PATH TO TEST;

GRANT ALL PRIVILEGES ON SCHEMA TEST TO my_user;

CREATE TABLE SystemUserSectionAccess(
  UserId INTEGER REFERENCES SystemUser(Id),
  --todo: remove to another entity
  Access VARCHAR(10) NOT NULL,
  SectionId INTEGER NOT NULL,
  CONSTRAINT SystemUserSectionAccess_SystemSection_FK FOREIGN KEY (SectionId)
  REFERENCES SystemSection(Id)
);