//
//  ChartData.swift
//  Returns
//
//  Created by James Chen on 2021/11/10.
//

import Foundation

struct ChartData {
    let portfolio: Portfolio

    // Close date based balance values.
    var balanceData: [Double] {
        portfolio.sortedBalanceData.map { $0.balance.doubleValue }
    }

    // TODO: calculate returns properly.
    // FIXME: growth data entries should be based on history returns, not balance changes.
    var growthData: [Double] {
        portfolio.sortedBalanceData.map { $0.balance.doubleValue }
    }

    // Account based most recent month balance values on close date (account name: account balance).
    var totalAssetsData: [String: Double] {
        portfolio.sortedAccounts.reduce(into: [String: Double]()) { result, account in
            result[account.name ?? ""] = account.currentBalance.balance.doubleValue
        }
    }
}