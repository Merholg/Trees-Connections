CREATE TABLE `Branches`(
    `BranchID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'ID ветки',
    `BranchName` TEXT NOT NULL COMMENT 'Наименование ветки',
    `BranchBeginNode` BIGINT NOT NULL,
    `BranchEndNode` BIGINT NOT NULL
);
CREATE TABLE `Nodes`(
    `NodeID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'ID узла',
    `NodeName` TEXT NOT NULL,
    `PointID` BIGINT NOT NULL
) COMMENT 'Пространственное положение каждой ноды и трассы каждой ветви';
CREATE TABLE `Points`(
    `PointID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `PointCoord` POINT NOT NULL COMMENT 'Координаты точки'
) COMMENT 'Пространственные точки';
ALTER TABLE
    `Points` ADD UNIQUE `points_pointcoord_unique`(`PointCoord`);
CREATE TABLE `TracePoint`(
    `PointID` BIGINT NOT NULL,
    `BranchID` BIGINT NOT NULL,
    `PointOrder` INT NOT NULL
) COMMENT 'Трассы из точек с порядком следования';
ALTER TABLE
    `TracePoint` ADD UNIQUE `tracepoint_pointid_branchid_pointorder_unique`(`PointID`, `BranchID`, `PointOrder`);
ALTER TABLE
    `Branches` ADD CONSTRAINT `branches_branchbeginnode_foreign` FOREIGN KEY(`BranchBeginNode`) REFERENCES `Nodes`(`NodeID`);
ALTER TABLE
    `TracePoint` ADD CONSTRAINT `tracepoint_pointid_foreign` FOREIGN KEY(`PointID`) REFERENCES `Points`(`PointID`);
ALTER TABLE
    `Branches` ADD CONSTRAINT `branches_branchendnode_foreign` FOREIGN KEY(`BranchEndNode`) REFERENCES `Nodes`(`NodeID`);
ALTER TABLE
    `TracePoint` ADD CONSTRAINT `tracepoint_branchid_foreign` FOREIGN KEY(`BranchID`) REFERENCES `Branches`(`BranchID`);
ALTER TABLE
    `Nodes` ADD CONSTRAINT `nodes_pointid_foreign` FOREIGN KEY(`PointID`) REFERENCES `Points`(`PointID`);