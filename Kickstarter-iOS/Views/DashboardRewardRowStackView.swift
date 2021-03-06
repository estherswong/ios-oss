import KsApi
import Library
import Prelude
import UIKit

internal final class DashboardRewardRowStackView: UIStackView {
  fileprivate let vm: DashboardRewardRowStackViewViewModelType = DashboardRewardRowStackViewViewModel()

  fileprivate let rewardsLabel: UILabel = UILabel()
  fileprivate let backersLabel: UILabel = UILabel()
  fileprivate let pledgedLabel: UILabel = UILabel()

  internal init(
    frame: CGRect,
    country: Project.Country,
    reward: ProjectStatsEnvelope.RewardStats,
    totalPledged: Int
  ) {
    super.init(frame: frame)

    _ = self
      |> dashboardStatsRowStackViewStyle
      |> UIStackView.lens.layoutMargins .~ .init(top: 0, left: Styles.grid(1), bottom: 0, right: 0)

    _ = self.rewardsLabel
      |> dashboardColumnTextLabelStyle
      |> UILabel.lens.font .~ UIFont.ksr_subhead().bolded
      |> UILabel.lens.numberOfLines .~ 0

    _ = self.pledgedLabel |> dashboardColumnTextLabelStyle
    _ = self.backersLabel |> dashboardColumnTextLabelStyle

    self.addArrangedSubview(self.rewardsLabel)
    self.addArrangedSubview(self.pledgedLabel)
    self.addArrangedSubview(self.backersLabel)

    self.rewardsLabel.rac.text = self.vm.outputs.topRewardText
    self.pledgedLabel.rac.text = self.vm.outputs.pledgedText
    self.backersLabel.rac.text = self.vm.outputs.backersText

    self.vm.inputs.configureWith(country: country, reward: reward, totalPledged: totalPledged)
  }

  required init(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
